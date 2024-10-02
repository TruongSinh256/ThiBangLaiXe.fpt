using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;

namespace ThiBangLaiXeClient.Controllers.User
{
    public class QuizController : Controller
    {
   
        public IActionResult Index()
        {
            return View();
        }

    }
}
