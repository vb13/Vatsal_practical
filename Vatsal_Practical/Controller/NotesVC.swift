//
//  NotesVC.swift
//  Vatsal_Practical
//
//  Created by VATSAL on 3/19/23.
//

import UIKit
import Alamofire
import ProgressHUD
import ObjectMapper
import SDWebImage


class NotesVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var cvProfile : UICollectionView!
    @IBOutlet weak var cvLike : UICollectionView!
    @IBOutlet weak var btnUpgrade : UIButton!
    @IBOutlet weak var heightConstCVLike : NSLayoutConstraint!
   //MARK: Varibles
    var arrProfiles =  [InviteProfiles]()
    var arrLikes =  [Profiles]()
    var context = CIContext(options: nil)
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        callNotesAPI()
    }
    override func viewDidLayoutSubviews() {
//        let  height = cvLike.collectionViewLayout.collectionViewContentSize.height
//        heightConstCVLike.constant = CGFloat(height)
//        self.view.setNeedsLayout() //Or self.view.layoutIfNeeded()
    }
    func setUI(){
        self.btnUpgrade.layer.cornerRadius =  self.btnUpgrade.frame.height / 2
    }
    
    
    //MARK: - API CALL
    func callNotesAPI() {
        ProgressHUD.show()
        let headers  : HTTPHeaders = ["Authorization": "\(UserDefaults.standard.value(forKey: "token") ?? "")"]
        let parametter = [:] as [String:Any]
        print("=============")
        print(headers)
        print("=============")
        AF.request(APIURL.NOTELIST, method: .get, parameters: parametter, encoding: URLEncoding.default,headers: headers).responseJSON { response in
          switch response.result {
          case .success (let value):
              ProgressHUD.dismiss()
            let dictResponse = value as? [String:Any]
              let dictInivite = dictResponse?["invites"] as? [String:Any]
              
              let objData = Mapper<NoteModel>().map(JSONObject: value)
              if let arr = objData?.invites?.inviteProfiles{
                  self.arrProfiles = arr
              }
              if let objLike = objData?.likes?.profiles{
                  self.arrLikes = objLike
              }
              
              self.cvLike.reloadData()
              self.cvProfile.reloadData()
              DispatchQueue.main.async {
                  self.viewDidLayoutSubviews()
              }
          case let .failure(error):
            print(error)
              ProgressHUD.dismiss()
          }
        }
        
        
    }
    //MARK: Button Action
    
}
//MARK: Collection View Methods
extension NotesVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView ==  cvProfile{
            return self.arrProfiles.count
        }else{
            return self.arrLikes.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileCVCell
        cell.imgProfile.roundCorners(corners: [.topRight, .bottomRight,.topLeft,.bottomLeft], radius: 10)
        if collectionView == self.cvProfile{
            
            cell.imgProfile.contentMode =  .scaleAspectFill
            let item = arrProfiles[indexPath.row]
            cell.lblName.text =  "\(item.genralInformation?.first_name ?? ""), \(item.genralInformation?.age ?? 0)"
            if let avtar = item.photos{
                if let imgUrl = avtar[0].photo{
                    cell.imgProfile.sd_setImage(with: URL(string: imgUrl))
                }
                
            }
        }else{
            let item = arrLikes[indexPath.row]
            cell.lblName.text =  "\(item.first_name ?? "")"
            cell.imgProfile.contentMode =  .scaleToFill
            if let imgUrl = item.avatar{
                cell.imgProfile.sd_setImage(with: URL(string: imgUrl))
//                self.blurEffect(bg: cell.imgProfile)
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                cell.imgProfile.addSubview(blurEffectView)
            }
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView ==  self.cvProfile{
            return CGSize(width: self.view.frame.width, height: self.cvProfile.frame.height)
        }else {
            return CGSize(width: self.cvLike.frame.width / 2, height: self.cvLike.frame.height)
        }
    }
    
    
//    func blurEffect(bg : UIImageView!) {
//
//        let currentFilter = CIFilter(name: "CIGaussianBlur")
//        let beginImage = CIImage(image: bg.image ?? UIImage())
//        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
//
//        let cropFilter = CIFilter(name: "CICrop")
//        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
//        cropFilter!.setValue(CIVector(cgRect: beginImage?.extent ?? CGRect()), forKey: "inputRectangle")
//
//        let output = cropFilter!.outputImage
//        let cgimg = context.createCGImage(output ?? CIImage(), from: output?.extent ?? CGRect())
//        let processedImage = UIImage(cgImage: cgimg ?? )
//        bg.image = processedImage
//    }
    
    
}
