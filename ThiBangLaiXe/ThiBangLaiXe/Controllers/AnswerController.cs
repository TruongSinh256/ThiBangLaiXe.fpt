using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ThiBangLaiXeAPI.Models.DataModels;
using ThiBangLaiXeAPI.Models.ViewModels;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AnswerController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;

        public AnswerController(ThiBangLaiXeContext context)
        {
            _context = context;
        }

        // GET: api/Answer
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AnswerQuestion>>> GetAnswers()
        {
            return await _context.AnswerQuestions.ToListAsync();
        }

        [HttpGet("{questionId}/{takeAnswerQuestionId}")]
        public bool checkAnswer(int questionId, int takeAnswerQuestionId)
        {
            var result = _context.AnswerQuestions.FirstOrDefault(x => x.AnswerId == takeAnswerQuestionId && x.QuestionId == questionId);
            if(result == null)
            {
                return false;
            }
            if (result.Correct)
            {
                return true;
            }
            else
            {
                return false;
            }
            
        }

        // GET: api/Answer/5
        [HttpGet("{id}")]
        public IActionResult GetAnswerByQuestionId(int id)
        {
            var answerList = _context.AnswerQuestions.Where(x => x.QuestionId == id).ToList();

            if (!answerList.Any())
            {
                return NotFound();
            }

            var questionVMs = new List<AnswerQuestionVM>();
            foreach (var answerQuestion in answerList)
            {
                var answerQuestionVM = new AnswerQuestionVM
                {
                    AnswerId = answerQuestion.AnswerId,
                    QuestionId = answerQuestion.QuestionId,
                    Correct = answerQuestion.Correct,
                    CreateAt = answerQuestion.CreateAt,
                    UpdateAt = answerQuestion.UpdateAt,
                    AnswerContent = answerQuestion.AnswerContent,
                    Active = answerQuestion.Active
                };
                questionVMs.Add(answerQuestionVM);
            }

            return Ok(questionVMs);
        }

        // POST: api/Answer
        [HttpPost]
        public async Task<ActionResult<IEnumerable<AnswerQuestion>>> PostAnswers([FromBody] List<AnswerQuestionVM> answerQuestions)
        {
            if (answerQuestions == null || !answerQuestions.Any())
            {
                return BadRequest("No answers provided.");
            }

            var answers = new List<AnswerQuestion>();

            foreach (var answerQuestionVM in answerQuestions)
            {
                var answerQuestion = new AnswerQuestion
                {
                    QuestionId = answerQuestionVM.QuestionId,
                    Correct = answerQuestionVM.Correct,
                    CreateAt = DateTime.Now,
                    UpdateAt = DateTime.Now,
                    AnswerContent = answerQuestionVM.AnswerContent,
                    Active = answerQuestionVM.Active
                };

                answers.Add(answerQuestion);
                _context.AnswerQuestions.Add(answerQuestion);
            }

            await _context.SaveChangesAsync();

            return Ok(answers);
        }

        // PUT: api/Answer/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutAnswer(int id, [FromBody] AnswerQuestionVM answerQuestionVM)
        {
            if (id != answerQuestionVM.AnswerId)
            {
                return BadRequest();
            }

            var answer = await _context.AnswerQuestions.FindAsync(id);

            if (answer == null)
            {
                return NotFound();
            }

            answer.QuestionId = answerQuestionVM.QuestionId;
            answer.Correct = answerQuestionVM.Correct;
            answer.AnswerContent = answerQuestionVM.AnswerContent;
            answer.Active = answerQuestionVM.Active;
            answer.UpdateAt = DateTime.Now;

            _context.Entry(answer).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AnswerExists(id))
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

        // DELETE: api/Answer/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteAnswer(int id)
        {
            var answer = await _context.AnswerQuestions.FindAsync(id);

            if (answer == null)
            {
                return NotFound();
            }

            _context.AnswerQuestions.Remove(answer);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool AnswerExists(int id)
        {
            return _context.AnswerQuestions.Any(e => e.AnswerId == id);
        }
    }
}

