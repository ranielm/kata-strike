//
//  AppDelegate.swift
//  KataStrike
//
//  Created by Raniel Mendonça on 10/02/2019.
//  Copyright © 2019 Raniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lista: UILabel!
    @IBOutlet weak var valor: UILabel!
    
    // var pontosEmCadaJogada = [1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6]
    // var pontosEmCadaJogada = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 2, 3, 0, 0]
    // var pontosEmCadaJogada = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 8, 2, 3, 0, 0]
    var pontosEmCadaJogada = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
    var posicoesJahAnalisadas = [0]
    var strike = false
    var spare = false
    var jogadaNormal = false
    var posicaoDoPinoNaJogada = 0
    var pontuacaoTotal = 0
    
    override func viewDidLoad() {
        self.lista.text = " "
        super.viewDidLoad()
        self.analisarJogadas()
    }
    
    func analisarJogadas(){
        let total = self.pontosEmCadaJogada.count
        for (jogada, pontos) in self.pontosEmCadaJogada.enumerated() {
            if jogada+1 < total {
                self.lista.text = self.lista.text! + " " + String(pontos)
                if !self.posicoesJahAnalisadas.contains(jogada+1) {
                    if pontos == 10 {
                        self.strike = true
                        self.posicaoDoPinoNaJogada = self.posicaoDoPinoNaJogada + 1
                        self.pontuarJogada(jogada: jogada, atual: pontos, total: total)
                    } else if pontos + self.pontosEmCadaJogada[jogada+1] == 10 {
                        self.spare = true
                        self.posicaoDoPinoNaJogada = self.posicaoDoPinoNaJogada + 1
                        self.pontuarJogada(jogada: jogada, atual: pontos, total: total)
                    } else {
                        self.jogadaNormal = true
                        self.posicaoDoPinoNaJogada = self.posicaoDoPinoNaJogada + 1
                        self.pontuarJogada(jogada: jogada, atual: pontos, total: total)
                    }
                }
            }
        }
        self.valor.text = String(self.pontuacaoTotal)
    }
    
    func pontuarJogada(jogada: Int, atual: Int, total: Int){
        let jogadaCorrente = jogada+1
        if self.strike == true {
            self.strike = false
            if (total - jogadaCorrente) >= 2 {
                self.pontuarValores(atual: atual, proximo: self.pontosEmCadaJogada[jogada+1], valorDoBonus: self.pontosEmCadaJogada[jogada+2])
            }
        } else if self.spare == true {
            self.spare = false
            self.pontuarValores(atual: atual, proximo: self.pontosEmCadaJogada[jogada+1], valorDoBonus: self.pontosEmCadaJogada[jogada+2])
            if self.pontosEmCadaJogada[jogada+1] != 10 {
                self.posicoesJahAnalisadas.append(jogada+2)
            }
        } else if self.jogadaNormal == true {
            self.pontuacaoTotal = self.pontuacaoTotal + atual + self.pontosEmCadaJogada[jogada+1]
            self.posicoesJahAnalisadas.append(jogada+2)
        }
    }
    
    func pontuarValores(atual: Int, proximo: Int, valorDoBonus: Int) {
        self.pontuacaoTotal = self.pontuacaoTotal + atual + proximo + valorDoBonus
    }
}
