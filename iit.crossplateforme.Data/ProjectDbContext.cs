using iit.crossplateforme.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Data
{
    public class ProjectDbContext : DbContext
    {
        public DbSet<Meal> Meals { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<Ingredient> Ingredients { get; set; }
        public IConfiguration Configuration { get; }
        protected override void OnConfiguring(DbContextOptionsBuilder

        optionsBuilder)

        => optionsBuilder.UseSqlite("datasource = C:/Users/boulbeba/Desktop/crossPlatformProj/iit.crossplateforme.Solution/DbRest.db");
    }
}
