using System;
using System.Collections.Generic;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class Quiz
    {
        public Quiz()
        {
            QuestionQuizzes = new HashSet<QuestionQuiz>();
            Takes = new HashSet<Take>();
        }

        public int QuizId { get; set; }
        public string Title { get; set; } = null!;
        public int CaId { get; set; }
        public double Score { get; set; }
        public int Time { get; set; }
        public string QuizContent { get; set; } = null!;

        public virtual Category Ca { get; set; } = null!;
        public virtual ICollection<QuestionQuiz> QuestionQuizzes { get; set; }
        public virtual ICollection<Take> Takes { get; set; }
    }
}
