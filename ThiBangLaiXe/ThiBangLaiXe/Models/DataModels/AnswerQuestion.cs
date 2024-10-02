using System;
using System.Collections.Generic;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class AnswerQuestion
    {
        public AnswerQuestion()
        {
            TakeAnswers = new HashSet<TakeAnswer>();
        }

        public int AnswerId { get; set; }
        public int QuestionId { get; set; }
        public bool Correct { get; set; }
        public DateTime CreateAt { get; set; }
        public DateTime UpdateAt { get; set; }
        public string AnswerContent { get; set; } = null!;
        public bool Active { get; set; }

        public virtual Question Question { get; set; } = null!;
        public virtual ICollection<TakeAnswer> TakeAnswers { get; set; }
    }
}
