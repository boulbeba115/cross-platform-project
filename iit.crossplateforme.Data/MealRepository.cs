using iit.crossplateforme.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Data
{
    public class MealRepository : IDataRepository<Meal>
    {
        private readonly ProjectDbContext _mealContext;

        public MealRepository(ProjectDbContext mealContext)
        {
            _mealContext = mealContext;
        }

        Meal IDataRepository<Meal>.Add(Meal entity)
        {
            var result = _mealContext.Meals.Add(entity).Entity;
            _mealContext.Entry(result.MealCategory).State = EntityState.Unchanged;
            result.Ingredients.ToList().ForEach(item => _mealContext.Entry(item).State = EntityState.Unchanged);
            _mealContext.SaveChanges();
            return result;
        }

        void IDataRepository<Meal>.Delete(long id)
        {
            _mealContext.Meals.Remove(_mealContext.Meals.Find(id));
            _mealContext.SaveChanges();
        }

        void IDataRepository<Meal>.Edit(Meal entity)
        {
            try
            {
                _mealContext.Entry(entity).State = EntityState.Modified;
                _mealContext.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }
        }

        Meal IDataRepository<Meal>.Get(long id)
        {
            return _mealContext.Meals.FirstOrDefault(item => id == item.MealId);
        }

        IList<Meal> IDataRepository<Meal>.GetAll()
        {
            return _mealContext.Meals.ToList();
        }
    }
}
