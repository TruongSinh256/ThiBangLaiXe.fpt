using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ThiBangLaiXeAPI.Models.DataModels;
using ThiBangLaiXeAPI.Models.ViewModels;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionQuizController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;

        public QuestionQuizController(ThiBangLaiXeContext context)
        {
            _context = context;
        }
        [HttpGet()]
        public IActionResult GetQuestionQuiz()
        {
            var result = _context.QuestionQuizzes.ToList();
            if (result == null)
            {
                return NotFound();
            }
            return Ok(result);
        }

        [HttpGet("id")]
        public IActionResult GetQuestionForQuiz(int id)
        {
            var result = _context.QuestionQuizzes.Where(x =>x.QuizId == id).ToList();
            if(result == null)
            {
                return NotFound();
            }
            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult> PostQuestionQuiz(List<QuestionQuizVM> questionQuizVM)
        {
            try
            {
                if (questionQuizVM == null || !questionQuizVM.Any())
                {
                    return BadRequest("No data provided.");
                }

                var questionQuizzes = questionQuizVM.Select(q => new QuestionQuiz
                {
              
                    QuestionId = q.QuestionId,
                    QuizId = q.QuizId
                }).ToList();

                _context.QuestionQuizzes.AddRange(questionQuizzes);
                await _context.SaveChangesAsync();

                return Ok("Questions added to quiz successfully.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }


    }
}
