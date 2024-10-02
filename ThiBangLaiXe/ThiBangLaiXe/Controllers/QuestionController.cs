using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ThiBangLaiXeAPI.Models.DataModels;
using ThiBangLaiXeAPI.Models.ViewModels;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;

        public QuestionController(ThiBangLaiXeContext context)
        {
            _context = context;
        }
        // GET: api/Question
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QuestionVM>>> GetQuestions()
        {
            var questions = await _context.Questions.Include(x => x.Ca).ToListAsync();
            List<QuestionVM> list = new List<QuestionVM>();
            foreach (var question in questions)
            {
                QuestionVM q = new QuestionVM()
                {
                    QuestionId = question.QuestionId,
                    CategoryName = question.Ca.CategoryName,
                    Score = question.Score,
                    QuestionContent = question.QuestionContent,
                    CreatedAt = question.CreatedAt,
                    UpdateAt = question.UpdateAt,
                    Status = question.Status,
                    ImageUrl = !string.IsNullOrEmpty(question.Image) ? $"wwwroot/images/{question.Image}" : null                   
                };
                list.Add(q);
            }
            return Ok(list);
        }

        // GET: api/Question/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QuestionVM>> GetQuestion(int id)
        {
            var question = await _context.Questions.FindAsync(id);

            if (question == null)
            {
                return NotFound();
            }
            var cate = _context.Categories.FirstOrDefault(x => x.CaId == (question.CaId));
            if (cate == null)
            {
                return BadRequest();
            }
            QuestionVM q = new QuestionVM()
            {
                QuestionId = question.QuestionId,
                CategoryName = cate.CategoryName,
                Score = question.Score,
                QuestionContent = question.QuestionContent,
                CreatedAt = question.CreatedAt,
                UpdateAt = question.UpdateAt,
                Status = question.Status,
                ImageUrl = !string.IsNullOrEmpty(question.Image) ? $"wwwroot/images/{question.Image}" : null,
            };

            return q;
        }

        // POST: api/Question
        [HttpPost]
        public async Task<ActionResult<QuestionVM>> PostQuestion([FromForm] QuestionVM question)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (question == null)
            {
                return BadRequest("Invalid data");
            }

            // Kiểm tra và lưu file ảnh nếu có
            string fileName = null;
            if (question.Image != null)
            {
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images", question.Image.FileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await question.Image.CopyToAsync(stream);
                }

                fileName = question.Image.FileName;
            }

            // Tạo đối tượng Question và lưu vào cơ sở dữ liệu
            var cate = _context.Categories.FirstOrDefault(x => x.CategoryName.Equals(question.CategoryName));
            if (cate == null)
            {
                return BadRequest("Category not found");
            }

            Question q = new Question()
            {
                CaId = cate.CaId,
                Score = question.Score,
                QuestionContent = question.QuestionContent,
                CreatedAt = DateTime.Now,
                UpdateAt = DateTime.Now,
                Status = question.Status,
                Image = fileName,
            };

            _context.Questions.Add(q);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetQuestion), new { id = q.QuestionId }, q);
        }


        // PUT: api/Question/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQuestion(int id, QuestionVM question)
        {
            if (id <= 0)
            {
                return BadRequest();
            }

            var cate = _context.Categories.FirstOrDefault(x => x.CategoryName.Equals(question.CategoryName));
            if (cate == null)
            {
                return BadRequest();
            }

            var existingQuestion = await _context.Questions.FindAsync(id);
            if (existingQuestion == null)
            {
                return NotFound();
            }

            // Update các thuộc tính của câu hỏi hiện tại
            existingQuestion.CaId = cate.CaId;
            existingQuestion.Score = question.Score;
            existingQuestion.QuestionContent = question.QuestionContent;
            existingQuestion.UpdateAt = DateTime.Now;
            existingQuestion.Status = question.Status;

            // Lưu file ảnh nếu có
            if (question.Image != null)
            {
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/images", question.Image.FileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await question.Image.CopyToAsync(stream);
                }

                existingQuestion.Image = question.Image.FileName;
            }

            try
            {
                // Thực hiện cập nhật vào cơ sở dữ liệu
                _context.Questions.Update(existingQuestion);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QuestionExists(question.QuestionContent))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }


        // DELETE: api/Question/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteQuestion(int id)
        {
            var question = await _context.Questions.FindAsync(id);
            if (question == null)
            {
                return NotFound();
            }

            var imageName = question.Image;

            // Nếu có tệp ảnh được lưu, xóa tệp ảnh từ thư mục wwwroot/images
            if (!string.IsNullOrEmpty(imageName))
            {
                var imagePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images", imageName);

                if (System.IO.File.Exists(imagePath))
                {
                    try
                    {
                        System.IO.File.Delete(imagePath);
                    }
                    catch (Exception ex)
                    {
                        // Log lỗi nếu cần
                        return StatusCode(500, $"Lỗi khi xóa tệp ảnh: {ex.Message}");
                    }
                }
            }

            _context.Questions.Remove(question);
            await _context.SaveChangesAsync();

            return NoContent();
        }


        private bool QuestionExists(string id)
        {
            return _context.Questions.Any(e => e.QuestionContent.Equals(id));
        }
    }
}
