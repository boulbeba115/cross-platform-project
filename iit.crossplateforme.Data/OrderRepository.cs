using iit.crossplateforme.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Data
{
    public class OrderRepository : IDataRepository<Order>
    {
        private readonly ProjectDbContext _orderContext;

        public OrderRepository(ProjectDbContext orderContext)
        {
            _orderContext = orderContext;
        }

        Order IDataRepository<Order>.Add(Order entity)
        {
            var result = _orderContext.Orders.Add(entity).Entity;
            _orderContext.SaveChanges();
            return result;
        }

        void IDataRepository<Order>.Delete(long id)
        {
            _orderContext.Orders.Remove(_orderContext.Orders.Find(id));
            _orderContext.SaveChanges();
        }

        void IDataRepository<Order>.Edit(Order entity)
        {
            try
            {
                _orderContext.Entry(entity).State = EntityState.Modified;
                _orderContext.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }
        }

        Order IDataRepository<Order>.Get(long id)
        {
            return _orderContext.Orders.FirstOrDefault(item => id == item.OrderId);
        }

        IList<Order> IDataRepository<Order>.GetAll()
        {
            return _orderContext.Orders.ToList();
        }
    }
}
