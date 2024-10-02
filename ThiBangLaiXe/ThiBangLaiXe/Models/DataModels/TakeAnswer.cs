using System;
using System.Collections.Generic;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class TakeAnswer
    {
        public int TakeAnswerId { get; set; }
        public int QuestionId { get; set; }
        public int AnswerId { get; set; }
        public int TakeId { get; set; }
        public string TakeAnswerContent { get; set; } = null!;

        public virtual AnswerQuestion Answer { get; set; } = null!;
        public virtual Question Question { get; set; } = null!;
        public virtual Take Take { get; set; } = null!;
    }
}
