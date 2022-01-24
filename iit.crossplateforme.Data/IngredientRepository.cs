using iit.crossplateforme.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Data
{
    public class IngredientRepository : IDataRepository<Ingredient>
    {
        private readonly ProjectDbContext _ingredientContext;

        public IngredientRepository(ProjectDbContext ingredientContext)
        {
            _ingredientContext = ingredientContext;
        }

        Ingredient IDataRepository<Ingredient>.Add(Ingredient entity)
        {
            var result = _ingredientContext.Ingredients.Add(entity).Entity;
            _ingredientContext.SaveChanges();
            return result;
        }

        void IDataRepository<Ingredient>.Delete(long id)
        {
            _ingredientContext.Ingredients.Remove(_ingredientContext.Ingredients.Find(id));
            _ingredientContext.SaveChanges();
        }

        void IDataRepository<Ingredient>.Edit(Ingredient entity)
        {
            try
            {
                _ingredientContext.Entry(entity).State = EntityState.Modified;
                _ingredientContext.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }
        }

        Ingredient IDataRepository<Ingredient>.Get(long id)
        {
            return _ingredientContext.Ingredients.FirstOrDefault(item => id == item.IngredientId);
        }

        IList<Ingredient> IDataRepository<Ingredient>.GetAll()
        {
            return _ingredientContext.Ingredients.ToList();
        }
    }
}
