using System;
using System.Collections.Generic;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class Take
    {
        public Take()
        {
            TakeAnswers = new HashSet<TakeAnswer>();
        }

        public int TakeId { get; set; }
        public int UserId { get; set; }
        public int QuizId { get; set; }
        public double Score { get; set; }
        public DateTime StartAt { get; set; }
        public DateTime EndAt { get; set; }
        public string TakeContent { get; set; } = null!;
        public bool Status { get; set; }

        public virtual Quiz Quiz { get; set; } = null!;
        public virtual User User { get; set; } = null!;
        public virtual ICollection<TakeAnswer> TakeAnswers { get; set; }
    }
}
