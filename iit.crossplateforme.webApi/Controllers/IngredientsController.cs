using iit.crossplateforme.Domain;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace iit.crossplateforme.webApi
{
    [Route("api/[controller]")]
    [ApiController]
    public class IngredientsController : ControllerBase
    {
        private readonly ILogger<IngredientsController> _logger;
        private readonly IDataRepository<Ingredient> _ingredientRepository;

        public IngredientsController(ILogger<IngredientsController> logger, IDataRepository<Ingredient> ingredientRepository)
        {
            _logger = logger;
            _ingredientRepository = ingredientRepository;
        }

        [HttpGet]
        public IEnumerable<Ingredient> GetAll()
        {
            return _ingredientRepository.GetAll();
        }

        [HttpGet("{id}")]
        public Ingredient Get(long id)
        {
            return _ingredientRepository.Get(id);
        }

        [HttpPut("{id}")]
        public void Edit(Ingredient ingredient)
        {
            _ingredientRepository.Edit(ingredient);
        }

        [HttpPost]
        public Ingredient Add(Ingredient ingredient)
        {
            return _ingredientRepository.Add(ingredient);
        }

        [HttpDelete("{id}")]
        public void Delete(long id)
        {
            _ingredientRepository.Delete(id);
        }
    }
}
