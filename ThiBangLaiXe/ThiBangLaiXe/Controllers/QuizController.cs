using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text;
using ThiBangLaiXeAPI.Models.DataModels;
using ThiBangLaiXeAPI.Models.ViewModels;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuizController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;

        public QuizController(ThiBangLaiXeContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<QuizVM>>> GetQuizzes()
        {
            var result = await _context.Quizzes.Include(x => x.Ca).Select(x => new QuizVM
            {
                QuizId = x.QuizId,
                Title = x.Title,
                CategoryName = x.Ca.CategoryName,
                Time = x.Time,
                Score = x.Score,
                QuizContent = x.QuizContent,

            }).ToListAsync();
            
            return result;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<QuizVM>> GetQuiz(int id)
        {
            var quiz = await _context.Quizzes.FindAsync(id);  
            
            if (quiz == null)
            {
                return NotFound();
            }
            var cate = await _context.Categories.FindAsync(quiz.CaId);
            if(cate == null)
            {
                return NotFound();
            }
            QuizVM quizVM = new QuizVM()
            {
                QuizId = quiz.QuizId,
                Title = quiz.Title,
                CategoryName = cate.CategoryName,
                Time = quiz.Time,
                Score = quiz.Score,
                QuizContent = quiz.QuizContent,
            };
            return quizVM;
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutQuiz(int id, QuizVM quiz)
        {
            if (id == null)
            {
                return BadRequest();
            }

            _context.Entry(quiz).State = EntityState.Modified;
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QuizExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Ok();
        }

        [HttpPost]
        public async Task<ActionResult<QuizVM>> PostQuiz(QuizVM quiz)
        {
            var result = _context.Categories.FirstOrDefault(x => x.CategoryName.Equals(quiz.CategoryName));
            Quiz quizVM = new Quiz()
            {
                QuizId = 0,
                Title = quiz.Title,
                CaId = result.CaId,
                Time = quiz.Time,
                Score = quiz.Score,
                QuizContent = quiz.QuizContent
                
            };  
            _context.Quizzes.Add(quizVM);
            await _context.SaveChangesAsync();
            return Ok(quizVM);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteQuiz(int id)
        {
            var quiz = await _context.Quizzes.FindAsync(id);
            var questionInQuiz = await _context.QuestionQuizzes
                                    .Where(qq => qq.QuizId == id)
                                    .ToListAsync();
            if (quiz == null)
            {
                return NotFound();
            }
            if(questionInQuiz != null)
            {
                _context.QuestionQuizzes.RemoveRange(questionInQuiz);
            }     
            _context.Quizzes.Remove(quiz);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool QuizExists(int id)
        {
            return _context.Quizzes.Any(e => e.QuizId == id);
        }
    }
}
