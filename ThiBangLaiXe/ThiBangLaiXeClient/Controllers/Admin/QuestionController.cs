using Microsoft.AspNetCore.Mvc;
using ThiBangLaiXeClient.ViewModels;

namespace ThiBangLaiXeClient.Controllers.Admin
{
    public class QuestionController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public IActionResult updateQuestion(int id)
        {

            return View();
        }

        public IActionResult addQuestion(int id)
        {

            return View();
        }

        [HttpGet]
        public IActionResult detailQuestion(int id)
        {
            return View();
        }
    }
}
