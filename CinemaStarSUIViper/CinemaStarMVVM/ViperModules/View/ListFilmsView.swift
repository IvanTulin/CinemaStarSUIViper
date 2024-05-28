// ListFilmsView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

///
struct ListFilmsView: View {
    enum Constants {
        static let textForTitleLabel = "Смотри исторические\nфильмы на "
        static let textBoldForTitleLabel = "CINEMA STAR"
        static let nameFont = "Inter"
        static let shimmerCellIdentifier = "shimmerCellIdentifier"
    }

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
        }
    }

//    @StateObject private var presenter = ListFilmsPresenter()
    @StateObject private var presenter: ListFilmsPresenter
    @State var selectedFilmId: String?
    @State var isShowDetailView = false

    init(presenter: ListFilmsPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    private var titleView: some View {
        HStack {
            Text(Constants.textForTitleLabel)
                +
                Text(Constants.textBoldForTitleLabel)
                .bold()
        }
    }

    private var filmListView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                if let films = presenter.films {
                    ForEach(films, id: \.id) { film in
                        NavigationLink(
                            destination: DetailsFilmView(id: $selectedFilmId),
                            isActive: $isShowDetailView
                        ) {
                            VStack {
                                AsyncImage(url: URL(string: film.poster)) { poster in
                                    poster
                                        .resizable()
                                        .frame(width: 170, height: 200)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack {
                                    Text(film.name)
                                        .frame(width: 150, alignment: .leading)
                                        .foregroundStyle(.white)
                                    Text("⭐️ \(String(format: "%.1f", film.rating))")
                                        .foregroundStyle(.white)
                                        .frame(width: 150, alignment: .leading)
                                }
                            }
                            .onTapGesture {
                                selectedFilmId = String(film.id)
                                isShowDetailView.toggle()
                            }
                            .background(Color.clear) // Фон для каждой ячейки
                            .cornerRadius(10) // Закругление углов ячейки
                            .shadow(radius: 5) // Добавление тени для ячейки
                            .padding(.vertical)
                        }
                    }
                }
            }
        }
    }
}

// #Preview {
//    ListFilmsView()
// }
