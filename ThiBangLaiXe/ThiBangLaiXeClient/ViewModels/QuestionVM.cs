using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace ThiBangLaiXeClient.ViewModels
{
    public class QuestionVM
    {
        [Required]
        public string CategoryName { get; set; }

        [Range(0, 100)]
        public double Score { get; set; }

        [Required]
        public string QuestionContent { get; set; } = null!;

        public DateTime CreatedAt { get; set; }
        public DateTime UpdateAt { get; set; }

        public bool Status { get; set; }

        public IFormFile? Image { get; set; }
        public string? ImageUrl { get; set; }
    }
}
