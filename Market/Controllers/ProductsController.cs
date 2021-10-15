using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using Market.Models;

namespace Market.Controllers
{
    public class ProductsController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            MarketContext db = new MarketContext();
            var products = db.Products.ToList();
            return View(products);
        }

        [HttpGet]
        public ActionResult Create()
        {
            var product = new Product();

            return View(product);
        }

        [HttpPost]
        public ActionResult Create(Product model)
        {
            if (!ModelState.IsValid)
                return View(model);

            var db = new MarketContext();
            model.CreateAt = DateTime.Now;

            db.Products.Add(model);
            db.SaveChanges();


            return RedirectPermanent("/Products/Index");
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            var db = new MarketContext();
            var product = db.Products.FirstOrDefault(x => x.Id == id);
            if (product == null)
                return RedirectPermanent("/Products/Index");

            db.Products.Remove(product);
            db.SaveChanges();

            return RedirectPermanent("/Products/Index");
        }

        [HttpGet]
        public ActionResult Edit(int id)
        {
            var db = new MarketContext();
            var product = db.Products.FirstOrDefault(x => x.Id == id);
            if (product == null)
                return RedirectPermanent("/Products/Index");

            return View(product);
        }

        [HttpPost]
        public ActionResult Edit(Product model)
        {

            var db = new MarketContext();
            var product = db.Products.FirstOrDefault(x => x.Id == model.Id);
            if (product == null)
            {
                ModelState.AddModelError("Id", "Продукт не найден");
            }
            if (!ModelState.IsValid)
                return View(model);

            MappingProduct(model, product);

            db.Entry(product).State = EntityState.Modified;
            db.SaveChanges();


            return RedirectPermanent("/Products/Index");
        }

        private void MappingProduct(Product sourse, Product destination)
        {
            destination.Name = sourse.Name;
            destination.Price = sourse.Price;
            destination.NumberOfProducts = sourse.NumberOfProducts;
            destination.Country = sourse.Country;
            destination.NextArrivalDate = sourse.NextArrivalDate;
        }
    }
}
