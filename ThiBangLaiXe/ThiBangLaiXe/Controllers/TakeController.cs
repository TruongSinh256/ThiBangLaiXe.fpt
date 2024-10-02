using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ThiBangLaiXeAPI.Models.DataModels;
using ThiBangLaiXeAPI.Models.ViewModels;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TakeController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;

        public TakeController(ThiBangLaiXeContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Take>>> GetTakes()
        {
            return await _context.Takes
                .Include(t => t.Quiz)
                .Include(t => t.User)
                .Include(t => t.TakeAnswers)
                .Select(x => new Take
                {
                    TakeId = x.TakeId,
                    UserId = x.UserId,
                    QuizId = x.QuizId,
                    Score = x.Score,
                    StartAt = x.StartAt,
                    EndAt = x.EndAt,
                    TakeContent = x.TakeContent,
                    TakeAnswers = x.TakeAnswers
                })
                .ToListAsync();
        }
        [HttpGet("take/{id}")]
        public async Task<ActionResult<TakeVM>> GetTakesById(int id)
        {
            var take = await _context.Takes.FindAsync(id);

            if (take == null)
            {
                return NotFound();
            }

            var takeVM = new TakeVM()
            {
                TakeId = take.TakeId,
                UserId = take.UserId,
                QuizId = take.QuizId,
                Score = take.Score,
                StartAt = take.StartAt,
                EndAt = take.EndAt,
                TakeContent = take.TakeContent,
            };

            return Ok(takeVM);
        }

        // GET: api/Take/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<IEnumerable<TakeVM>>> GetTakeByUserId(int id)
        {
            var take =  await _context.Takes
                .Include(t => t.Quiz)
                .Include(t => t.User)
                .Include(t => t.TakeAnswers)
                .Where(t => t.UserId == id).Select(x => new TakeVM
                {
                    TakeId = x.TakeId,
                    UserId = x.UserId,
                    QuizId = x.QuizId,
                    Score = x.Score,
                    StartAt = x.StartAt,
                    EndAt = x.EndAt,
                    TakeContent = x.TakeContent,
                })
                .ToListAsync();

            if (take == null)
            {
                return NotFound();
            }

            return take;
        }



        // POST: api/Take
        [HttpPost]
        public async Task<ActionResult<TakeVM>> CreateTake(TakeVM x)
        {
            Take t = new Take()
            {
                TakeId = x.TakeId,
                UserId = x.UserId,
                QuizId = x.QuizId,
                Score = x.Score,
                StartAt = x.StartAt,
                EndAt = x.EndAt,
                TakeContent = x.TakeContent,
            };
            _context.Takes.Add(t);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetTakesById), new { id = t.TakeId }, t);
        
        }

        // PUT: api/Take/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateTake(int id, Take take)
        {
            if (id != take.TakeId)
            {
                return BadRequest();
            }

            _context.Entry(take).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TakeExists(id))
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

        // DELETE: api/Take/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteTake(int id)
        {
            var take = await _context.Takes.FindAsync(id);
            if (take == null)
            {
                return NotFound();
            }

            _context.Takes.Remove(take);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool TakeExists(int id)
        {
            return _context.Takes.Any(t => t.TakeId == id);
        }
    }
}
