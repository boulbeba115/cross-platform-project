using iit.crossplateforme.Domain;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Data
{
    public class CategoryRepository : IDataRepository<Category>
    {
        private readonly ProjectDbContext _categoryContext;
        public CategoryRepository(ProjectDbContext categoryContext)
        {
            _categoryContext = categoryContext;
        }

        Category IDataRepository<Category>.Add(Category entity)
        {
            var result = _categoryContext.Categories.Add(entity).Entity;
            _categoryContext.SaveChanges();
            return result;
        }

        void IDataRepository<Category>.Delete(long id)
        {
            _categoryContext.Categories.Remove(_categoryContext.Categories.Find(id));
            _categoryContext.SaveChanges();
        }

        void IDataRepository<Category>.Edit(Category entity)
        {
            try
            {
                _categoryContext.Entry(entity).State = EntityState.Modified;
                _categoryContext.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }
        }

        Category IDataRepository<Category>.Get(long id)
        {
            return _categoryContext.Categories.FirstOrDefault(item => id == item.CategoryId);
        }

        IList<Category> IDataRepository<Category>.GetAll()
        {
            return _categoryContext.Categories.ToList();
        }
    }
}
