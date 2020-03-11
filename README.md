# Aweb

Project for creating database relations between users using layout design from [Layout Design](https://www.behance.net/gallery/14286087/Twitter-Redesign-of-UI-details)

Link to live version [Aweb](https://jaak-aweb.herokuapp.com/)

## Screenshot

![Screenshot of the webpage](https://github.com/Jaakal/aweb/blob/master/screenshot.png)

## Getting Started

Clone the repository into your local computer.

### Prerequisites

Ruby, '2.6.4'

Ruby on Rails, '~> 6.0.2', '>= 6.0.2.1'

### Setup

Instal gems with:

```
bundle install
```

Setup database with:

```
   rails db:create
   rails db:migrate
   rails db:seed
```

### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

## Running the tests

Tests are ran with the command on the console in the project root directory:

```
Rspec --format document
```

## Deployment

In order to deploy it to Heroku, then one the console in root directory of the project run commands in order shown below (current branch needs to be master):

```
heroku apps:create <app-name>

git add .
git commit -m "Deploy to Heroku"
git push heroku master

heroku run rails db:migrate
heroku open

```

## Built With

* [Ruby](https://www.ruby-lang.org/en/) - Programming language used
* [Ruby on Rails](https://rubyonrails.org/) - Ruby framework used
* [HTML](https://en.wikipedia.org/wiki/HTML) - Hypertext Markup Language
* [CSS](https://www.w3.org/Style/CSS/Overview.en.html) - Cascading Style Sheets
* [JavaScript](https://www.javascript.com/) - Programming language used
* [VS Code](https://code.visualstudio.com/) - The code editor used 

## Authors

👤 **Jaak Kivinukk**

<a href="https://github.com/Jaakal" target="_blank">
    
  ![Screenshot Image](app/assets/images/jaak-profile.png) 

</a>

- Github: [@Jaakal](https://github.com/Jaakal)
- Twitter: [@JKivinukk](https://twitter.com/JKivinukk)
- Linkedin: [Jaak Kivinukk](https://www.linkedin.com/in/jaak-kivinukk-7098b1153/)
- Email: [jaak.kivinukk@gmail.com](jaak.kivinukk@gmail.com)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments
* [Layout Design](https://www.behance.net/gallery/14286087/Twitter-Redesign-of-UI-details) - template used for reference
