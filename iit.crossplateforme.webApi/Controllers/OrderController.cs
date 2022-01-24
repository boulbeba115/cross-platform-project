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
    public class OrderController : ControllerBase
    {
        private readonly ILogger<OrderController> _logger;
        private readonly IDataRepository<Order> _orderRepository;
        public OrderController(ILogger<OrderController> logger, IDataRepository<Order> orderRepository)
        {
            _logger = logger;
            _orderRepository = orderRepository;
        }

        [HttpGet]
        public IEnumerable<Order> GetAll()
        {
            return _orderRepository.GetAll();
        }

        [HttpGet("{id}")]
        public Order Get(long id)
        {
            return _orderRepository.Get(id);
        }

        [HttpPut("{id}")]
        public void Edit(Order order)
        {
            _orderRepository.Edit(order);
        }

        [HttpPost]
        public Order Add(Order order)
        {
            return _orderRepository.Add(order);
        }

        [HttpDelete("{id}")]
        public void Delete(long id)
        {
            _orderRepository.Delete(id);
        }

    }
}
