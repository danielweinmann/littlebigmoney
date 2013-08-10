CATARSE.Project = Backbone.Model.extend({
  urlRoot: '/donate/projects',
	initialize: function() {
		this.backers = new CATARSE.Backers()
		this.backers.url = '/' + CATARSE.locale + '/donate/projects/' + this.id + '/backers'
	}
})
