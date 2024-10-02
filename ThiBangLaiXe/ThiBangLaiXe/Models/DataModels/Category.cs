using System;
using System.Collections.Generic;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class Category
    {
        public Category()
        {
            Questions = new HashSet<Question>();
            Quizzes = new HashSet<Quiz>();
        }

        public int CaId { get; set; }
        public string CategoryName { get; set; } = null!;
        public string CategoryContent { get; set; } = null!;

        public virtual ICollection<Quiz> Quizzes { get; set; }
        public virtual ICollection<Question> Questions { get; set; }
    }
}
