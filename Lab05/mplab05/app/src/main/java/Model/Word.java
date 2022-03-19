package Model;

public class Word {
    public String engWord;
    public String monWord;
    public int wordId;

    //get methods
    public String getEngWord(){
        return engWord;
    }
    public String getMonWord(){
        return monWord;
    }
    public int getWordId(){
        return wordId;
    }

    //set methods
    public void setEngWord(String engWord){
        this.engWord = engWord;
    }
    public void setMonWord(String monWord){
        this.monWord = monWord;
    }
    public void setWordId(int wordId){
        this.wordId = wordId;
    }

}
