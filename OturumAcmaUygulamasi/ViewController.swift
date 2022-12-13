//
//  ViewController.swift
//  OturumAcmaUygulamasi
//
//  Created by Muhammed Gül on 8.11.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtEmailAdresi: UITextField!
    @IBOutlet weak var txtParola: UITextField!
    
    enum OturumHatasi : Error {
        case doldurulmayanAlanlar
        case parolaFormatiGecersiz
        case emailFormatiGecersiz
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func BtnClicked(_ sender: UIButton) {
        do {
            try oturumAcma()
            mesajVer(baslik: "Başarılı", mesaj: "Oturum Başarılı bir şekilde açıldı")
        } catch OturumHatasi.doldurulmayanAlanlar {
            mesajVer(baslik: "Doldurulmayan Alanlar", mesaj: "Hiçbir alanı boş bırakmayanız")
        } catch OturumHatasi.emailFormatiGecersiz {
            mesajVer(baslik: "Email Formatı Geçersiz", mesaj: "Düzgün Bir Email Adresi Giriniz")
        } catch OturumHatasi.parolaFormatiGecersiz {
            mesajVer(baslik: "Parola formatı Geçersiz", mesaj: "En az bir büyük, bir küçük harf, rakam içermeli.Toplamda 8 karakter.")
        } catch let bilinmeyenHata {
            mesajVer(baslik: "Bilinmeyen Hata", mesaj: "Sebebi bilinmeyen Bir Hata Meydana Geldi"+bilinmeyenHata.localizedDescription)
        }
    }
    
    func mesajVer(baslik : String , mesaj : String) {
        let alert = UIAlertController(title: baslik, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func oturumAcma() throws {
        let emailAdres = txtEmailAdresi.text!
        let parola = txtParola.text!
        
        if emailAdres.isEmpty || parola.isEmpty {
            throw OturumHatasi.doldurulmayanAlanlar
        }
        
        if emailAdres.mailFormatKontrol == false {
            throw OturumHatasi.emailFormatiGecersiz
        }
        
        if parola.parolaFormatKontrol == false {
            throw OturumHatasi.parolaFormatiGecersiz
        }
    }
    
    
}

extension String {
    var mailFormatKontrol : Bool {
        
        let emailFormat : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        
        let sonuc : Bool = predicate.evaluate(with: self)
        return sonuc
    }
    
    var parolaFormatKontrol : Bool {
        let parolaFormat = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", parolaFormat)
        let sonuc = predicate.evaluate(with: self)
        return sonuc
    }
}
