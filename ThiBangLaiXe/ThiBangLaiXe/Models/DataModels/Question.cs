using System;
using System.Collections.Generic;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class Question
    {
        public Question()
        {
            AnswerQuestions = new HashSet<AnswerQuestion>();
            QuestionQuizzes = new HashSet<QuestionQuiz>();
            TakeAnswers = new HashSet<TakeAnswer>();
        }

        public int QuestionId { get; set; }
        public int CaId { get; set; }
        public double Score { get; set; }
        public string QuestionContent { get; set; } = null!;
        public DateTime CreatedAt { get; set; }
        public DateTime UpdateAt { get; set; }
        public bool Status { get; set; }
        public string? Image { get; set; }

        public virtual Category Ca { get; set; } = null!;
        public virtual ICollection<AnswerQuestion> AnswerQuestions { get; set; }
        public virtual ICollection<QuestionQuiz> QuestionQuizzes { get; set; }
        public virtual ICollection<TakeAnswer> TakeAnswers { get; set; }
    }
}
