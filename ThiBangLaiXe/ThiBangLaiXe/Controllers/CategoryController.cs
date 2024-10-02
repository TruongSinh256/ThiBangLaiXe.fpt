using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ThiBangLaiXeAPI.Models.DataModels;
using ThiBangLaiXeAPI.Models.ViewModels;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;

        public CategoryController(ThiBangLaiXeContext context)
        {
            _context = context;
        }

        // GET: api/Categories
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Category>>> GetCategories()
        {
            return await _context.Categories.ToListAsync();
        }

        // GET: api/Categories/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Category>> GetCategory(int id)
        {
            var category = await _context.Categories.FindAsync(id);

            if (category == null)
            {
                return NotFound();
            }

            return category;
        }

        // PUT: api/Categories/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCategory(int id, CategoryVM categoryVM)
        {
            if (id==null)
            {
                return BadRequest();
            }
            try
            {
                Category category = new Category()
                {
                    CaId = id,
                    CategoryName = categoryVM.CategoryName,
                    CategoryContent = categoryVM.CategoryContent
                };
                _context.Update(category);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CategoryExists(categoryVM.CategoryName))
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

        // POST: api/Categories
        [HttpPost]
        public async Task<ActionResult<Category>> PostCategory(CategoryVM categoryVM)
        {
            if (CategoryExists(categoryVM.CategoryName))
            {
                return BadRequest();
            }
            Category category = new Category()
            { 
                CategoryName = categoryVM.CategoryName,
                CategoryContent = categoryVM.CategoryContent
            };
            _context.Categories.Add(category);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCategory), new { id = category.CaId }, category);
        }

        // DELETE: api/Categories/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            var category = await _context.Categories.FindAsync(id);
            if (category == null)
            {
                return NotFound();
            }

            _context.Categories.Remove(category);
            await _context.SaveChangesAsync();

            return Ok();
        }

        private bool CategoryExists(string name)
        {
            return _context.Categories.Any(e => e.CategoryName.Equals(name));
        }
    }

}

