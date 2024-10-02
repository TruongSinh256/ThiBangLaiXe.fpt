namespace ThiBangLaiXeAPI.Models.ViewModels
{
    public class TakeVM
    {
        public int TakeId { get; set; }
        public int UserId { get; set; }
        public int QuizId { get; set; }
        public double Score { get; set; }
        public DateTime StartAt { get; set; }
        public DateTime EndAt { get; set; }
        public string TakeContent { get; set; } = null!;
        public bool Status { get; set; }

    }
}
