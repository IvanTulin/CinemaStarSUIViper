// ListFilmsView.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftUI

///
struct ListFilmsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.cream, Color.darkGreen]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                VStack {
                    titleView
                        .padding(.trailing, 150)
                    filmListView
                }
            }
        }
        .onAppear {
            presenter.fetchFilms()
            // presenter.viewDidLoad()
        }
        .onReceive(presenter.filmsPublisher, perform: { films in
            self.films = films

        })
    }

    @StateObject private var presenter: ListFilmsPresenter
    @State var selectedFilmId: String?
    @State var isShowDetailView = false
    @State var films: [FilmsCommonInfo]?

    init(presenter: ListFilmsPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    private var cancellable: Set<AnyCancellable> = []

    private var titleView: some View {
        HStack {
            Text(Constants.textForTitleLabel)
                +
                Text(Constants.textLabel)
                .bold()
        }
    }

    private var filmListView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                // if let films = presenter.films {
                if let films = films {
                    ForEach(films, id: \.id) { film in
                        VStack {
                            AsyncImage(url: URL(string: film.poster)) { poster in
                                poster
                                    .resizable()
                                    .frame(width: 170, height: 200)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(8)
                            } placeholder: {
                                // ProgressView()
                                ShimmerPlaceholderView()
                                    .modifier(ShimmerEffect())
                            }
                            VStack {
                                Text(film.name)
                                    .frame(width: 150, alignment: .leading)
                                    .foregroundStyle(.white)
                                Text("⭐️ \(String(format: "%.1f", film.rating))")
                                    .foregroundStyle(.white)
                                    .frame(width: 150, alignment: .leading)
                            }
                            .frame(height: 65)
                        }
                        .onTapGesture {
                            // presenter.selectedFilmId = String(film.id)
                            selectedFilmId = String(film.id)
                            presenter.didSelectFilm(with: $selectedFilmId)
                            // presenter.didSelectFilm(with: String(film.id))
                            // presenter.isShowDetailView.toggle()
                        }
                        .background(Color.clear) // Фон для каждой ячейки
                        .cornerRadius(10) // Закругление углов ячейки
                        .shadow(radius: 5) // Добавление тени для ячейки
                        .padding(.vertical)
                        // }
                    }
                }
            }
        }
    }
}

// #Preview {
//    ListFilmsView()
// }
