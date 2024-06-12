// DetailsFilmView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

struct DetailsFilmView: View {
    @Binding var id: String?

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.cream, Color.darkGreen]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                hidenButtons
                Spacer().frame(height: 22)
                detailFilmListView
            }
        }
        .onAppear {
            presenter.fetchDetailsFilm(id: id ?? "")
        }
        .onReceive(presenter.filmsPublisher, perform: { details in
            detailsFilm = details
        })
    }

    @StateObject var presenter: DetailsFilmPresenter
    @State var isShowAlert = false
    @State var detailsFilm: DetailsFilmCommonInfo?

    private var hidenButtons: some View {
        HStack {
            Button(action: {
                presenter.returnListFilm()
            }, label: {
                Image(systemName: Constants.backButtonName)
            })
            .tint(.white)
            .padding(.leading, 11)
            Spacer()

            Button(action: {}, label: {
                Image(systemName: Constants.heartButton)
            })
            .tint(.white)
            .padding(.trailing, 11)
        }
    }

    private var detailFilmListView: some View {
        ScrollView {
            if let details = detailsFilm {
                filmHeader(details: details)
                filmDescription(details: details)
                filmCast(details: details)
                filmLanguage(details: details)
                filmRecommendations(details: details)
            }
        }
        .listStyle(.plain)
        .listRowBackground(Color.clear)
    }

    // Подвид для заголовка фильма
    private func filmHeader(details: DetailsFilmCommonInfo) -> some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: details.poster)) { poster in
                    poster
                        .resizable()
                        .frame(width: 170, height: 200)
                        .background(.white)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                Text("\(details.name)\n" + "⭐️ \(String(format: "%.1f", details.rating.kp))")
                    .frame(width: 140, height: 80, alignment: .leading)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
            }
            .offset(x: -12)

            Button(Constants.nameButton) {
                isShowAlert = true
            }
            .alert(isPresented: $isShowAlert, content: {
                Alert(title: Text(Constants.textForAlert), dismissButton: .cancel(Text("Ok")))
            })
            .frame(width: 358, height: 48)
            .foregroundColor(.white)
            .background(.darkGreen)
            .cornerRadius(12)
        }
    }

    // Подвид для описания фильма
    private func filmDescription(details: DetailsFilmCommonInfo) -> some View {
        Text("\(details.description)")
            .foregroundStyle(.white)
            .frame(width: 330, height: 100, alignment: .leading)
            .offset(x: -15)
    }

    // Подвид для актерского состава
    private func filmCast(details: DetailsFilmCommonInfo) -> some View {
        VStack {
            Text(Constants.actorName)
                .bold()
                .foregroundStyle(.white)
                .frame(width: 330, height: 20, alignment: .leading)
                .offset(x: -15)

            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 8) {
                    if let actors = details.persons {
                        ForEach(actors, id: \.self) { person in
                            VStack {
                                if let photo = person.photo {
                                    AsyncImage(url: URL(string: photo)) { photo in
                                        photo
                                            .resizable()
                                            .frame(width: 46, height: 73)
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                Text(person.name ?? "")
                                    .font(.system(size: 7))
                                    .foregroundStyle(.white)
                                    .frame(width: 50, height: 25, alignment: .center)
                            }
                        }
                    }
                }
            }
            .frame(height: 125)
        }
    }

    // Подвид для языка фильма
    private func filmLanguage(details: DetailsFilmCommonInfo) -> some View {
        VStack {
            Text("Язык")
                .bold()
                .foregroundStyle(.white)
                .offset(x: -21)
            Text("\(details.spokenLanguages?.first?.name ?? "")")
                .foregroundStyle(.dirtyGreen)
                .offset(x: -9)
        }
        .offset(x: -139)
    }

    // Подвид для рекомендаций фильмов
    private func filmRecommendations(details: DetailsFilmCommonInfo) -> some View {
        VStack {
            Text(Constants.seeAlso)
                .bold()
                .foregroundStyle(.white)
                .frame(alignment: .leading)
                .offset(x: -111)
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 18) {
                    if let similarMovies = details.similarMovies {
                        ForEach(similarMovies, id: \.self) { recommendation in
                            VStack {
                                if let photo = recommendation.poster?.url {
                                    AsyncImage(url: URL(string: photo)) { photo in
                                        photo
                                            .resizable()
                                            .frame(width: 170, height: 200)
                                            .aspectRatio(contentMode: .fill)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                Text(recommendation.name ?? "")
                                    .foregroundStyle(.white)
                                    .frame(alignment: .leading)
                                    .offset(x: -37)
                            }
                        }
                    }
                }
            }
            .frame(height: 250)
        }
    }
}

// #Preview {
//    DetailsFilmView(id: "")
// }
