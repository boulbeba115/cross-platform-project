using iit.crossplateforme.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Data
{
    public class UserRepository : IDataRepository<User>
    {
        private readonly ProjectDbContext _userContext;

        public UserRepository(ProjectDbContext userContext)
        {
            _userContext = userContext;
        }

        User IDataRepository<User>.Add(User entity)
        {
            var result = _userContext.Users.Add(entity).Entity;
            _userContext.SaveChanges();
            return result;
        }

        public void Delete(long id)
        {
            _userContext.Users.Remove(_userContext.Users.Find(id));
            _userContext.SaveChanges();
        }

        public void Edit(User entity)
        {
            try
            {
                _userContext.Entry(entity).State = EntityState.Modified;
                _userContext.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }
        }

        public User Get(long id)
        {
            return _userContext.Users.FirstOrDefault(item => id == item.UserId);
        }

        public IList<User> GetAll()
        {
            return _userContext.Users.ToList();
        }
    }
}
