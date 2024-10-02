using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text.Json;
using ThiBangLaiXeClient.ViewModels;

namespace ThiBangLaiXeClient.Controllers.User
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IHttpClientFactory _httpClientFactory;
        private string urlQuiz = "http://localhost:7151/api/Quiz";
        public HomeController(ILogger<HomeController> logger, IHttpClientFactory httpClientFactory)
        {
            _logger = logger;
            _httpClientFactory = httpClientFactory;
        }

        public async Task<IActionResult> Index()
        {
            var client = _httpClientFactory.CreateClient();
            var response = await client.GetStringAsync(urlQuiz);
            try
            {
                var quizList = JsonSerializer.Deserialize<List<QuizVM>>(response, new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                });

                return View(quizList);
            }
            catch (Exception ex)
            {             
                throw;
            }      
        }

        public IActionResult Privacy()
        {
            return View();
        }



    }
}