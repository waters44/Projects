/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package pkg255project;

/**
 *
 * @author lucywaters
 */

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;

public class TicTacToe extends JFrame {
    JButton[][] nineButtons;
    JLabel scoreLabel;
    Player player1;
    Player player2;
    Player currentTurn;
    Random randomNumbers;
    boolean gameWasWon;
    int player1Score = 0;
    int player2Score = 0;


    
    public TicTacToe(boolean isPVP) {
        nineButtons = new JButton[3][3];
        scoreLabel = new JLabel("Score - You: 0 | Player 2: 0");
        scoreLabel.setHorizontalAlignment(SwingConstants.CENTER);
        scoreLabel.setFont(new Font("Arial", Font.BOLD, 16));
        
        setLayout(new BorderLayout());
        JPanel boardPanel = new JPanel(new GridLayout(3, 3));
        
        // Initialize buttons and add them to the board panel
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                nineButtons[i][j] = new JButton(" ");
                nineButtons[i][j].setFont(new Font("Arial", Font.PLAIN, 40));
                nineButtons[i][j].addActionListener(new ActionListener() {
                    public void actionPerformed(ActionEvent evt) {
                        clickButton(evt);
                    }
                });
                boardPanel.add(nineButtons[i][j]);
            }
        }
        
        add(scoreLabel, BorderLayout.NORTH);
        add(boardPanel, BorderLayout.CENTER);

        player1 = new HumanPlayer();
        if(isPVP)
        {
            player2= new HumanPlayer('O', Color.blue);
        }
        else
        {
            player2 = new ComputerPlayer();
        }
        currentTurn = player1;
        randomNumbers = new Random();

        setSize(400, 450);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
    }

    public void clickButton(ActionEvent evt) {
        if (currentTurn instanceof ComputerPlayer) 
            return;

        JButton buttonClicked = (JButton) evt.getSource();
        boolean result = placeSymbol(buttonClicked, currentTurn);

        if (!result) {
        }
    }

    public boolean placeSymbol(JButton button, Player player) {
        if (gameWasWon || !button.getText().equals(" ")) {
            return false;
        } else {
            button.setText(String.valueOf(player.symbol));
            button.setForeground(player.color);
            changeTurn();
            return true;
        }
    }

    public void changeTurn() {
        if (checkWin()) 
            return;
        
        if(currentTurn == player1)
        {
            currentTurn = player2;
            //takeComputerTurn();
        }
        else
        {
            currentTurn = player1;
            
        }
        
        if (currentTurn instanceof ComputerPlayer) {
                takeComputerTurn();
        }
        }

    public boolean checkWin() {
        Player whoWon = checkWhoWon();
        boolean boardIsFull = isFull();

        if (whoWon == null && boardIsFull) {
            JOptionPane.showMessageDialog(null, "It's a tie!");
            resetBoard();
            return true;
        }

        if (whoWon == player1) {
            player1Score++;
            JOptionPane.showMessageDialog(null, "You won!");
            updateScore();
            resetBoard();
            return true;
        }

        if (whoWon == player2) {
            player2Score++;
            JOptionPane.showMessageDialog(null, "Player 2 won!");
            updateScore();
            resetBoard();
            return true;
        }

        return false;
    }

    public Player checkWhoWon() {
        for (int i = 0; i < 3; i++) {
            if (!nineButtons[i][0].getText().equals(" ") && 
                nineButtons[i][0].getText().equals(nineButtons[i][1].getText()) && 
                nineButtons[i][0].getText().equals(nineButtons[i][2].getText())) {
                return nineButtons[i][0].getText().equals("X") ? player1 : player2;
            }

            if (!nineButtons[0][i].getText().equals(" ") && 
                nineButtons[0][i].getText().equals(nineButtons[1][i].getText()) && 
                nineButtons[0][i].getText().equals(nineButtons[2][i].getText())) {
                return nineButtons[0][i].getText().equals("X") ? player1 : player2;
            }
        }

        if (!nineButtons[0][0].getText().equals(" ") && 
            nineButtons[0][0].getText().equals(nineButtons[1][1].getText()) && 
            nineButtons[0][0].getText().equals(nineButtons[2][2].getText())) {
            return nineButtons[0][0].getText().equals("X") ? player1 : player2;
        }

        if (!nineButtons[0][2].getText().equals(" ") && 
            nineButtons[0][2].getText().equals(nineButtons[1][1].getText()) && 
            nineButtons[0][2].getText().equals(nineButtons[2][0].getText())) {
            return nineButtons[0][2].getText().equals("X") ? player1 : player2;
        }

        return null;
    }

    public boolean isFull() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (nineButtons[i][j].getText().equals(" ")) {
                    return false;
                }
            }
        }
        return true;
    }

    public void resetBoard() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                nineButtons[i][j].setText(" ");
                nineButtons[i][j].setForeground(Color.BLACK);
            }
        }
        gameWasWon = false;
        currentTurn = player1;
    }

    public void updateScore() {
        scoreLabel.setText("Score - You: " + player1Score + " | Player 2: " + player2Score);
    }

    public void runGame() {
        /*gameWasWon = false;

        while (!gameWasWon) {
            if (currentTurn instanceof ComputerPlayer) {
                takeComputerTurn();
                //();
            } else {
                try {
                    Thread.sleep(200);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }*/
    }

    public void takeComputerTurn() {
        if (isFull()) 
            return;

        boolean result = false;
        while (!result) {
            int row = randomNumbers.nextInt(3);
            int col = randomNumbers.nextInt(3);
            JButton buttonPicked = nineButtons[row][col];
            
            result = placeSymbol(buttonPicked, player2);
            
            if (buttonPicked.getText().isEmpty()) {
            result = placeSymbol(buttonPicked, player2);
            }
        }
        
    }

}