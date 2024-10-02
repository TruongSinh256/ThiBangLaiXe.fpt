using Microsoft.AspNetCore.Http;
using ThiBangLaiXeAPI.Models.DataModels;

namespace ThiBangLaiXeAPI.Models.ViewModels
{
    public class QuestionVM
    {
 
        public int QuestionId { get; set; }
        public string CategoryName { get; set; }
        public double Score { get; set; }
        public string QuestionContent { get; set; } = null!;
        public DateTime CreatedAt { get; set; }
        public DateTime UpdateAt { get; set; }
        public bool Status { get; set; }

        public IFormFile? Image { get; set; }
        public string? ImageUrl { get; set; }

    }
}
