using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ThiBangLaiXeAPI.Models.DataModels
{
    public partial class ThiBangLaiXeContext : DbContext
    {
        public ThiBangLaiXeContext()
        {
        }

        public ThiBangLaiXeContext(DbContextOptions<ThiBangLaiXeContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AnswerQuestion> AnswerQuestions { get; set; } = null!;
        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<Question> Questions { get; set; } = null!;
        public virtual DbSet<QuestionQuiz> QuestionQuizzes { get; set; } = null!;
        public virtual DbSet<Quiz> Quizzes { get; set; } = null!;
        public virtual DbSet<Take> Takes { get; set; } = null!;
        public virtual DbSet<TakeAnswer> TakeAnswers { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var builder = new ConfigurationBuilder()
                            .SetBasePath(Directory.GetCurrentDirectory())
                            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
                IConfigurationRoot configuration = builder.Build();
                optionsBuilder.UseSqlServer(configuration.GetConnectionString("DBContext"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AnswerQuestion>(entity =>
            {
                entity.HasKey(e => e.AnswerId);

                entity.ToTable("answer_question");

                entity.Property(e => e.AnswerId).HasColumnName("answerID");

                entity.Property(e => e.Active).HasColumnName("active");

                entity.Property(e => e.AnswerContent).HasColumnName("answerContent");

                entity.Property(e => e.Correct).HasColumnName("correct");

                entity.Property(e => e.CreateAt)
                    .HasColumnType("datetime")
                    .HasColumnName("createAt");

                entity.Property(e => e.QuestionId).HasColumnName("questionID");

                entity.Property(e => e.UpdateAt)
                    .HasColumnType("datetime")
                    .HasColumnName("updateAt");

                entity.HasOne(d => d.Question)
                    .WithMany(p => p.AnswerQuestions)
                    .HasForeignKey(d => d.QuestionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_answer_question_question");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.HasKey(e => e.CaId);

                entity.ToTable("category");

                entity.Property(e => e.CaId).HasColumnName("caID");

                entity.Property(e => e.CategoryContent)
                    .HasMaxLength(100)
                    .HasColumnName("categoryContent");

                entity.Property(e => e.CategoryName)
                    .HasMaxLength(50)
                    .HasColumnName("categoryName");
            });

            modelBuilder.Entity<Question>(entity =>
            {
                entity.ToTable("question");

                entity.Property(e => e.QuestionId).HasColumnName("questionID");

                entity.Property(e => e.CaId).HasColumnName("caID");

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasColumnName("createdAt");

                entity.Property(e => e.QuestionContent).HasColumnName("questionContent");

                entity.Property(e => e.Score).HasColumnName("score");

                entity.Property(e => e.Status).HasColumnName("status");

                entity.Property(e => e.UpdateAt)
                    .HasColumnType("datetime")
                    .HasColumnName("updateAt");

                entity.HasOne(d => d.Ca)
                    .WithMany(p => p.Questions)
                    .HasForeignKey(d => d.CaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_question_category");
            });

            modelBuilder.Entity<QuestionQuiz>(entity =>
            {
                entity.ToTable("question_quiz");

                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).ValueGeneratedOnAdd();
                entity.Property(e => e.QuestionId).HasColumnName("questionID");

                entity.Property(e => e.QuizId).HasColumnName("quizID");

                entity.HasOne(d => d.Question)
                    .WithMany(p => p.QuestionQuizzes)
                    .HasForeignKey(d => d.QuestionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_question_quiz_question");

                entity.HasOne(d => d.Quiz)
                    .WithMany(p => p.QuestionQuizzes)
                    .HasForeignKey(d => d.QuizId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_question_quiz_quiz");
            });

            modelBuilder.Entity<Quiz>(entity =>
            {
                entity.ToTable("quiz");

                entity.Property(e => e.QuizId).HasColumnName("quizID");

                entity.Property(e => e.CaId).HasColumnName("caID");

                entity.Property(e => e.QuizContent).HasColumnName("quizContent");

                entity.Property(e => e.Score).HasColumnName("score");

                entity.Property(e => e.Time).HasColumnName("time");

                entity.Property(e => e.Title)
                    .HasMaxLength(100)
                    .HasColumnName("title");

                entity.HasOne(d => d.Ca)
                    .WithMany(p => p.Quizzes)
                    .HasForeignKey(d => d.CaId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_quiz_category");
            });

            modelBuilder.Entity<Take>(entity =>
            {
                entity.ToTable("take");

                entity.Property(e => e.TakeId).HasColumnName("takeID");

                entity.Property(e => e.EndAt)
                    .HasColumnType("datetime")
                    .HasColumnName("endAt");

                entity.Property(e => e.QuizId).HasColumnName("quizID");

                entity.Property(e => e.Score).HasColumnName("score");

                entity.Property(e => e.StartAt)
                    .HasColumnType("datetime")
                    .HasColumnName("startAt");

                entity.Property(e => e.Status).HasColumnName("status");

                entity.Property(e => e.TakeContent).HasColumnName("takeContent");

                entity.Property(e => e.UserId).HasColumnName("userID");

                entity.HasOne(d => d.Quiz)
                    .WithMany(p => p.Takes)
                    .HasForeignKey(d => d.QuizId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_take_quiz");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Takes)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_take_user");
            });

            modelBuilder.Entity<TakeAnswer>(entity =>
            {
                entity.ToTable("take_answer");

                entity.Property(e => e.TakeAnswerId).HasColumnName("take_answerID");

                entity.Property(e => e.AnswerId).HasColumnName("answerID");

                entity.Property(e => e.QuestionId).HasColumnName("questionID");

                entity.Property(e => e.TakeAnswerContent).HasColumnName("take_answerContent");

                entity.Property(e => e.TakeId).HasColumnName("takeID");

                entity.HasOne(d => d.Answer)
                    .WithMany(p => p.TakeAnswers)
                    .HasForeignKey(d => d.AnswerId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_take_answer_answer_question");

                entity.HasOne(d => d.Question)
                    .WithMany(p => p.TakeAnswers)
                    .HasForeignKey(d => d.QuestionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_take_answer_question");

                entity.HasOne(d => d.Take)
                    .WithMany(p => p.TakeAnswers)
                    .HasForeignKey(d => d.TakeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_take_answer_take");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasKey(e => e.Uid);

                entity.ToTable("user");

                entity.Property(e => e.Uid).HasColumnName("UID");

                entity.Property(e => e.Email)
                    .HasMaxLength(100)
                    .HasColumnName("email");

                entity.Property(e => e.FirstName)
                    .HasMaxLength(50)
                    .HasColumnName("firstName");

                entity.Property(e => e.LastName)
                    .HasMaxLength(50)
                    .HasColumnName("lastName");

                entity.Property(e => e.Password)
                    .HasMaxLength(50)
                    .HasColumnName("password")
                    .IsFixedLength();

                entity.Property(e => e.Phone)
                    .HasMaxLength(12)
                    .HasColumnName("phone")
                    .IsFixedLength();

                entity.Property(e => e.Status).HasColumnName("status");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
