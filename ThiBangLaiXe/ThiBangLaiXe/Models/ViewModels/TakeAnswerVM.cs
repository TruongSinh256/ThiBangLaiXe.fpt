namespace ThiBangLaiXeAPI.Models.ViewModels
{
    public class TakeAnswerVM
    {
        public int TakeAnswerId { get; set; }
        public int QuestionId { get; set; }
        public int AnswerId { get; set; }
        public int TakeId { get; set; }
        public string TakeAnswerContent { get; set; } = null!;
    }
}
