using iit.crossplateforme.Domain;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace iit.crossplateforme.webApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MealController : ControllerBase
    {
        private readonly ILogger<MealController> _logger;
        private readonly IDataRepository<Meal> _mealRepository;

        public MealController(ILogger<MealController> logger, IDataRepository<Meal> mealRepository)
        {
            _logger = logger;
            _mealRepository = mealRepository;
        }

        [HttpGet]
        public IEnumerable<Meal> GetAll()
        {
            return _mealRepository.GetAll();
        }

        [HttpGet("{id}")]
        public Meal Get(long id)
        {
            return _mealRepository.Get(id);
        }

        [HttpPut("{id}")]
        public void Edit(Meal meal)
        {
            _mealRepository.Edit(meal);
        }

        [HttpPost]
        public Meal Add(Meal meal)
        {
            return _mealRepository.Add(meal);
        }

        [HttpDelete("{id}")]
        public void Delete(long id)
        {
            _mealRepository.Delete(id);
        }
    }
}
