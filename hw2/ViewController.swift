import UIKit

class ViewController: UIViewController {

    let colors: [UIColor] = [.red, .yellow, .green]
    var currentIndex = 0
    var trafficLightViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTrafficLight()
        
        trafficLightViews[0].backgroundColor = UIColor.red
        trafficLightViews[1].backgroundColor = UIColor.gray
        trafficLightViews[2].backgroundColor = UIColor.gray

        let changeColorButton = makeButton(title: "Сменить цвет", backgroundColor: .lightGray, cornerRadius: 12)
        

        
        changeColorButton.addAction(UIAction { [weak self] _ in
            self?.changeTrafficLightColor()
        }, for: .touchUpInside)
    }


    func createTrafficLight() {
        for color in colors {
            let circleView = UIView()
            circleView.backgroundColor = color
            circleView.translatesAutoresizingMaskIntoConstraints = false
            circleView.layer.cornerRadius = 60
            view.addSubview(circleView)
            trafficLightViews.append(circleView)
        }
        for (index, circleView) in trafficLightViews.enumerated() {
            NSLayoutConstraint.activate([
                circleView.widthAnchor.constraint(equalToConstant: 120),
                circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
                circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                circleView.topAnchor.constraint(equalTo: (index == 0) ? view.safeAreaLayoutGuide.topAnchor : trafficLightViews[index - 1].bottomAnchor, constant: 40)
            ])
        }
    }


    func changeTrafficLightColor() {
        currentIndex = (currentIndex + 1) % colors.count

        UIView.animate(withDuration: 1) {
            self.trafficLightViews.enumerated().forEach { index, circleView in
                circleView.backgroundColor = (index == self.currentIndex) ? self.colors[index] : .gray
            }
        }
    }

     func makeButton(title: String, backgroundColor: UIColor, cornerRadius: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 75),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: trafficLightViews.last!.bottomAnchor, constant: 20)
        ])

        return button
    }
}
