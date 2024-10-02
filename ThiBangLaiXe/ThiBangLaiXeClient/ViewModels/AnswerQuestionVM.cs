namespace ThiBangLaiXeClient.ViewModels
{
    public class AnswerQuestionVM
    {
        public int AnswerId { get; set; }
        public int QuestionId { get; set; }
        public bool Correct { get; set; }
        public DateTime CreateAt { get; set; }
        public DateTime UpdateAt { get; set; }
        public string AnswerContent { get; set; } = null!;
        public bool Active { get; set; }
    }
}
