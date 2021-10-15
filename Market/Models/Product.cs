using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Market.Models
{
    public class Product
    {
        /// <summary>
        /// Id
        /// </summary> 
        [HiddenInput(DisplayValue = false)]
        public int Id { get; set; }

        /// <summary>
        /// Название
        /// </summary> 
        [Required]
        [Display(Name = "Название", Order = 5)]
        public string Name { get; set; }

        /// <summary>
        /// Цена
        /// </summary> 
        [Required]
        [Display(Name = "Цена", Order = 10)]
        public decimal Price { get; set; }

        /// <summary>
        /// Количество продуктов
        /// </summary> 
        [Required]
        [Display(Name = "Количество продукта в наличии", Order = 20)]
        public int NumberOfProducts { get; set; }

        /// <summary>
        /// Страна-производитель
        /// </summary> 
        [Required]
        [Display(Name = "Страна-производитель", Order = 30)]
        public string Country{ get; set; }

        /// <summary>
        /// Дата следующего поступления
        /// </summary> 
        [Required]
        [Display(Name = "Дата следующего поступления", Order = 40)]
        public DateTime NextArrivalDate { get; set; }

        /// <summary>
        /// Дата создания записи
        /// </summary> 
        [ScaffoldColumn(false)]
        public DateTime CreateAt { get; set; }
    }
}