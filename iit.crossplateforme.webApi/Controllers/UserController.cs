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
    public class UserController : ControllerBase
    {
        private readonly ILogger<UserController> _logger;
        private readonly IDataRepository<User> _userRepository;
        public UserController(ILogger<UserController> logger, IDataRepository<User> userRepository)
        {
            _logger = logger;
            _userRepository = userRepository;
        }

        [HttpGet]
        public IEnumerable<User> GetAll()
        {
            return _userRepository.GetAll();
        }

        [HttpGet("{id}")]
        public User Get(long id)
        {
            return _userRepository.Get(id);
        }

        [HttpPut("{id}")]
        public void Edit(User user)
        {
            _userRepository.Edit(user);
        }

        [HttpPost]
        public User Add(User user)
        {
            return _userRepository.Add(user);
        }

        [HttpDelete("{id}")]
        public void Delete(long id)
        {
            _userRepository.Delete(id);
        }
    }
}
