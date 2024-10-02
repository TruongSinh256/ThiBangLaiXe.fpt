using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ThiBangLaiXeAPI.Models;
using ThiBangLaiXeAPI.Models.DataModels;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Claims;

namespace ThiBangLaiXeAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly ThiBangLaiXeContext _context;
        private readonly JwtHelper _jwtHelper;

        public UserController(ThiBangLaiXeContext context, JwtHelper jwtHelper)
        {
            _context = context;
            _jwtHelper = jwtHelper;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginModel loginModel)
        {
            if (loginModel == null)
            {
                return BadRequest("Invalid client request");
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == loginModel.Email && u.Password == loginModel.Password);

            if (user == null)
            {
                return Unauthorized("Invalid email or password");
            }

            // Kiểm tra nếu tài khoản là admin
            bool isAdmin = user.Email == "admin"; // Hoặc bất kỳ logic nào để xác định tài khoản admin

            var token = _jwtHelper.GenerateToken(user.Email, isAdmin);
            return Ok(new { Token = token, Name = user.Email });
        }

        [HttpPost("logout")]
        public IActionResult Logout()
        {
            // With JWT, there's no need to clear sessions.
            // Clients simply discard the token.
            return Ok("Logout successful");
        }

        [HttpGet("me")]
        [Authorize]
        public IActionResult Me()
        {
            var userClaims = User.Claims;
            if (userClaims == null)
            {
                return Unauthorized("User not authenticated");
            }

            var userId = userClaims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var email = userClaims.FirstOrDefault(c => c.Type == ClaimTypes.Name)?.Value;

            if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(email))
            {
                return Unauthorized("User information not found in token");
            }

            return Ok(new { UserId = userId, Email = email });
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterModel registerModel)
        {
            if (registerModel == null)
            {
                return BadRequest("Invalid client request");
            }

            var userExists = await _context.Users
                .FirstOrDefaultAsync(u => u.Email == registerModel.Email);

            if (userExists != null)
            {
                return BadRequest("User already exists");
            }

            var user = new User
            {
                FirstName = registerModel.FirstName,
                LastName = registerModel.LastName,
                Email = registerModel.Email,
                Phone = registerModel.Phone,
                Password = registerModel.Password, // Consider hashing the password
                Status = true
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return Ok("User registered successfully");
        }
    }

    public class RegisterModel
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Password { get; set; }
    }

    public class LoginModel
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
