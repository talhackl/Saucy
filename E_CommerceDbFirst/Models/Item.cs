//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace E_CommerceDbFirst.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Item
    {
        public Item()
        {
            this.Carts = new HashSet<Cart>();
            this.Orders = new HashSet<Order>();
            this.Ingredients = new HashSet<Ingredient>();
        }
    
        public int ItemId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string ImageUrl { get; set; }
        public int CategoriesId { get; set; }
        public bool IsDisable { get; set; }
    
        public virtual ICollection<Cart> Carts { get; set; }
        public virtual Category Category { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Ingredient> Ingredients { get; set; }
    }
}
