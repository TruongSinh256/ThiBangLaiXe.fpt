using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ThiBangLaiXeAPI.Models.DataModels;
using ThiBangLaiXeAPI.Models.ViewModels;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TakeAnswerController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;

        public TakeAnswerController(ThiBangLaiXeContext context)
        {
            _context = context;
        }

        [HttpGet("id")]
        public IActionResult Get(int id)
        {
            var result = _context.TakeAnswers.Where(x => x.TakeId == id).ToList();
            List<TakeAnswerVM> answers = new List<TakeAnswerVM>();

            foreach (var answerTake in result)
            {
                var answerQuestion = new TakeAnswerVM
                {
                    TakeAnswerId = answerTake.TakeId,
                    QuestionId = answerTake.QuestionId,
                    AnswerId = answerTake.AnswerId,
                    TakeId = answerTake.TakeId,
                    TakeAnswerContent = answerTake.TakeAnswerContent
                };

                answers.Add(answerQuestion);             
            }
            return Ok(answers);
        }

        [HttpPost]
        public async Task<ActionResult<List<TakeAnswerVM>>> PostTakeAnswerQuestion(List<TakeAnswerVM> answerQuestions)
        {
            if (answerQuestions == null || !answerQuestions.Any())
            {
                return BadRequest("No answers provided.");
            }

            try
            {
                List<TakeAnswer> answers = new List<TakeAnswer>();

                foreach (var answerTake in answerQuestions)
                {
                    var answerQuestion = new TakeAnswer
                    {
                        QuestionId = answerTake.QuestionId,
                        AnswerId = answerTake.AnswerId,
                        TakeId = answerTake.TakeId,
                        TakeAnswerContent = answerTake.TakeAnswerContent
                    };

                    answers.Add(answerQuestion);
                    _context.TakeAnswers.Add(answerQuestion);
                }

                await _context.SaveChangesAsync();

                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
