using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using CRUD_Operation.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace CRUD_Operation.Controllers
{
    [Route("Category")]
    public class CategoryController : Controller
    {
        
        private static List<Category> Catagories = new List<Category>
        {
            new Category { Id = 1, name = "Electronics", description = "Electronics Products" },
            new Category { Id = 2, name = "Food", description = "Tasty Products" },
            new Category { Id = 3, name = "Smart Phone", description = "iPhone 50", isActive = false},
            new Category { Id = 4, name = "Programming Books", description = "C# Learning Books" },
            new Category { Id = 5, name = "Clothing", description = "Mens Collection", isActive = false}
        };

        [HttpGet("")]      
        public IActionResult Index()
        {
            return View(Catagories);
        }
        
        [HttpGet("Create")]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost("Create")]
        public IActionResult Create(Category category)
        {
            category.Id = Catagories.Count +1;

            Catagories.Add(category);

            return RedirectToAction ("Index");
        }


        [HttpGet("Edit/{id}")]
        public IActionResult Edit(int id)
        {
            var category = Catagories.FirstOrDefault(c => c.Id == id);

            if(category == null)
            {
                return NotFound();
            }

            return View(category);
        }


        [HttpPost("Edit/{id}")]
        public IActionResult Edit (int ID, Category category)
        {
            var existingCategory = Catagories.FirstOrDefault(c => c.Id == ID);

            if(existingCategory == null)
            {
                return NotFound();
            }


            existingCategory.name = category.name;
            existingCategory.description = category.description;
            existingCategory.isActive = category.isActive;

            return RedirectToAction("Index");

        }

        
        
        [HttpGet("Delete/{id}")]
        public IActionResult Delete(int ID)
        {
            var category = Catagories.FirstOrDefault(c => c.Id == ID);

            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }


        [HttpPost("Delete/{id}")]
        public IActionResult DeleteConfirmed(int ID)
        {
            var category = Catagories.FirstOrDefault(c => c.Id == ID);

            if(category == null)
            {
                return NotFound();
            }
            
            Catagories.Remove(category);

            return RedirectToAction("Index");
        }

    }
}