using ThiBangLaiXeAPI.Models.DataModels;

namespace ThiBangLaiXeAPI.Models.ViewModels
{
    public class QuizVM
    {
        public int QuizId { get; set; }
        public string Title { get; set; } = null!;
        public string CategoryName { get; set; }     
        public int Time { get; set; }
        public double Score { get; set; }
        public string QuizContent { get; set; } = null!;
        
    }
}
