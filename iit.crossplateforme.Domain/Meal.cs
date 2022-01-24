using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iit.crossplateforme.Domain
{

    public class Meal
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long MealId { get; set; }
        public String MealName { get; set; }
        public String MealImg { get; set; }
        public double MealPrice { get; set; }
        public String MealDescription { get; set; }
        public Category MealCategory { get; set; }
        public ICollection<Ingredient> Ingredients { get; set; }
        public bool isGlutenFree { get; set; }
        public bool isLactoseFree { get; set; }
        public bool isVegan { get; set; }
        public bool isVegetarian { get; set; }

    }
}
