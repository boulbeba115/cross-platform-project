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
    public class CategoryController : ControllerBase
    {
        private readonly ILogger<CategoryController> _logger;
        private readonly IDataRepository<Category> _categoryRepository;

        public CategoryController(ILogger<CategoryController> logger, IDataRepository<Category> categoryRepository)
        {
            _logger = logger;
            _categoryRepository = categoryRepository;
        }

        [HttpGet]
        public IEnumerable<Category> GetAll()
        {
            return _categoryRepository.GetAll();
        }

        [HttpGet("{id}")]
        public Category Get(long id)
        {
            return _categoryRepository.Get(id);
        }

        [HttpPut("{id}")]
        public void Edit(Category category)
        {
            _categoryRepository.Edit(category);
        }

        [HttpPost]
        public Category Add(Category category)
        {
           return _categoryRepository.Add(category);
        }

        [HttpDelete("{id}")]
        public void Delete(long id)
        {
            _categoryRepository.Delete(id);
        }
    }
}
