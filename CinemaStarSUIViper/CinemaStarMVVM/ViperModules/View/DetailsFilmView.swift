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
            detailFilmListView
        }
        .onAppear {
            viewModel.fetch(id: id ?? "")
        }
    }

    @StateObject private var viewModel = DetailsFilmViewModel2()

    private var detailFilmListView: some View {
        List {
            VStack {
                if let detailFilms = viewModel.detailFilms.first {
                    HStack {
                        AsyncImage(url: URL(string: detailFilms.poster)) { poster in
                            poster
                                .resizable()
                                .frame(width: 170, height: 200)
                                .background(.white)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                        Text("\(detailFilms.name)\n" + "⭐️ \(String(format: "%.1f", detailFilms.rating.kp))")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .offset(x: -52)

                    Button("Смотреть") {}
                        .frame(width: 358, height: 48)
                        .foregroundColor(.white)
                        .background(.darkGreen)
                        .cornerRadius(12)

                    Text("\(detailFilms.description)")
                        .foregroundStyle(.white)
                        .frame(width: 330, height: 100, alignment: .leading)
                        .offset(x: -15)

                    Text(
                        "\(String(detailFilms.year))/\(detailFilms.countries.first?.name ?? "")/ \(detailFilms.type)"
                    )
                    .foregroundStyle(.white)
                    .frame(width: 330, height: 20, alignment: .leading)
                    .offset(x: -15)

                    Spacer().frame(height: 40)

                    Text("Актеры и сьемочная группа")
                        .bold()
                        .foregroundStyle(.white)
                        .frame(width: 330, height: 20, alignment: .leading)
                        .offset(x: -15)

                    Spacer().frame(height: 5)

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.flexible())], spacing: 8, content: {
                            if let persons = detailFilms.persons {
                                ForEach(persons, id: \.self) { person in
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
                                        Spacer().frame(height: 1)
                                        Text(person.name ?? "")
                                            .font(.system(size: 7))
                                            .foregroundStyle(.white)
                                            .frame(width: 50, height: 25, alignment: .center)
                                    }
                                }
                            }
                        })
                    }
                    .frame(height: 125)

                    HStack {
                        VStack {
                            Text("Язык")
                                .bold()
                                .foregroundStyle(.white)
                                .offset(x: -21)
                            Text("\(detailFilms.spokenLanguages?.first?.name ?? "")")
                                .foregroundStyle(.dirtyGreen)
                                .offset(x: -9)
                        }
                    }
                    .offset(x: -139)

                    Spacer().frame(height: 20)

                    HStack {
                        VStack {
                            Text("Смотрите также")
                                .bold()
                                .foregroundStyle(.white)
                                .frame(alignment: .leading)
                                .offset(x: -111)
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem(.flexible())], spacing: 18, content: {
                                    if let recomendationFilms = detailFilms.similarMovies {
                                        ForEach(recomendationFilms, id: \.self) { recomendation in
                                            VStack {
                                                if let photo = recomendation.poster?.url {
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

                                                Text(recomendation.name ?? "")
                                                    .foregroundStyle(.white)
                                                    .frame(alignment: .leading)
                                                    .offset(x: -37)
                                            }
                                        }
                                    }
                                })
                            }
                            .frame(height: 250)
                        }
                        Spacer()
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
    }
}

// #Preview {
//    DetailsFilmView(id: "")
// }
