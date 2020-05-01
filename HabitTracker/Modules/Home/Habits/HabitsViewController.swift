//
//  HabitsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import SegementSlide
import PinLayout

final class HabitsViewController: UIViewController {

    lazy var addHabitButton: UIButton = {
        let btn = UIButton(frame: .zero)
        
        btn.apply(style: .blue)
        btn.title = "Add habit  +"
        
        return btn
    }()
    
    @IBOutlet var tableView: UITableView!
    
    var items: [Habit] = [
        Habit(title: "Wake up early",
              notes: "workout",
              duration: 10,
              startData: Date(),
              schedule: [.monday, .wednesday, .friday],
              backgroundImage: Asset.illustration1.image),
        Habit(title: "Evening meditation",
              notes: "relax",
              duration: 20,
              startData: Date(),
              schedule: [.monday, .wednesday, .friday],
              backgroundImage: Asset.illustration2.image),
        Habit(title: "Abs burning workout",
              notes: "Abs",
              duration: 15,
              startData: Date(),
              schedule: [.monday, .wednesday, .friday],
              backgroundImage: Asset.illustration3.image),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(addHabitButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 8
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        addHabitButton.addTarget(self, action: #selector(addHabitDidTap), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addHabitButton
            .pin
            .left(16)
            .right(16)
            .bottom(view.safeAreaInsets.bottom + 16)
            .height(50)
    }
    
    @objc
    func addHabitDidTap() {
        let controller = HabitDetailsViewController()
        controller.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

extension HabitsViewController: SegementSlideContentScrollViewDelegate {
    
}

extension HabitsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HabitCell.identifier, for: indexPath) as? HabitCell else {
            return UITableViewCell()
        }
        
        cell.configure(model: items[indexPath.row])
        
        return cell
    }
    
}

extension HabitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
