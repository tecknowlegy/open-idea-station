// use caching and chaining for faster querying of DOM
// $(document).ready(function () {
//   // save a selector in memory (caching)
//   getStartedBtn = $('.get-started-btn');
//   function addEffect() {
//     // use function chaining to act on the chached button
//     getStartedBtn.addClass('red').fadeIn(500);
//   }

//   // Use this to reduce the need to query the DOM for a particular element
//   $('get-started-btn').click(function() {
//     $(this).html('Starting Idea App');
//   })

//   // Defining selector context
//   // THis is how to access child nodes within a parent element in jquery

//   // First way
//   card = $("IdeaCard");
//   getIconsInCard(card);

//   function getIconsInCard(card) {
//     iconsInCard = $('.icons', card); // saves in a variable, all icon class within card parent element
//     iconsInCard.addClass('red')
//   }

//   // Best way
//   function getIconsInCard(card) {
//     iconsInCard = card.find('.icons')
//   }
// })