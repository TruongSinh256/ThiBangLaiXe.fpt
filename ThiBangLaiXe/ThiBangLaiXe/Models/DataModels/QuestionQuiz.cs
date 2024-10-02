using System;
using System.Collections.Generic;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class QuestionQuiz
    {
        public int Id { get; set; }
        public int QuestionId { get; set; }
        public int QuizId { get; set; }

        public virtual Question Question { get; set; } = null!;
        public virtual Quiz Quiz { get; set; } = null!;
    }
}
