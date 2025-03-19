const newsGrid = document.querySelector('.news-grid');
const articlesGrid = document.querySelector('.articles-grid');

//  Пример данных для новостей и статей (в реальности данные будут получаться с сервера)
const newsData = [
    {
        title: "Заголовок новости 1",
        image: "images/news1.jpg",
        description: "Краткое описание новости 1..."
    },
    {
        title: "Заголовок новости 2",
        image: "images/news2.jpg",
        description: "Краткое описание новости 2..."
    },
    // ... еще новости
];

const articlesData = [
    {
        title: "Заголовок статьи 1",
        image: "images/article1.jpg",
        description: "Краткое описание статьи 1..."
    },
    {
        title: "Заголовок статьи 2",
        image: "images/article2.jpg",
        description: "Краткое описание статьи 2..."
    },
    // ... еще статьи
];

//  Функция для создания элемента новости/статьи
function createNewsItem(data) {
    const newsItem = document.createElement('div');
    newsItem.classList.add('news-item');
    newsItem.innerHTML = `
        <img src="${data.image}" alt="${data.title}">
        <h3>${data.title}</h3>
        <p>${data.description}</p>
    `;
    return newsItem;
}

//  Функция для создания элемента статьи
function createArticleItem(data) {
    const articleItem = document.createElement('div');
    articleItem.classList.add('article-item');
    articleItem.innerHTML = `
        <img src="${data.image}" alt="${data.title}">
        <h3>${data.title}</h3>
        <p>${data.description}</p>
    `;
    return articleItem;
}

//  Заполнение сетки новостей
newsData.forEach(news => {
    const newsItem = createNewsItem(news);
    newsGrid.appendChild(newsItem);
});

//  Заполнение сетки статей
articlesData.forEach(article => {
    const articleItem = createArticleItem(article);
    articlesGrid.appendChild(articleItem);
});

//  Пример добавления функциональности для кнопок (клик по кнопке "Узнать больше")
const buttons = document.querySelectorAll('.button');

buttons.forEach(button => {
    button.addEventListener('click', () => {
        //  Добавьте сюда код для обработки клика по кнопке
        //  Например, можно перенаправить пользователя на другую страницу
        console.log("Клик по кнопке");
    });
});