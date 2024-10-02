using Microsoft.AspNetCore.Mvc;

namespace ThiBangLaiXeClient.Controllers.Admin
{
    public class HomeController : Controller
    {
        public IActionResult HomeAdmin()
        {
            return View();
        }

    }
}
